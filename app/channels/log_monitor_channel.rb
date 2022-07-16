class LogMonitorChannel < ApplicationCable::Channel
  def subscribed
    stream_from "log_monitor" 
    log_file_path = Rails.root.join('log/development.log').to_s

    file_content = File.open(log_file_path).readlines
    ActionCable.server.broadcast('log_monitor', { log: file_content.last(20), type: "current_log" } )

    Filewatcher.new([log_file_path]).watch do |_file_path, event_type|
      next unless event_type.to_s.eql?('updated')

      file_lines = added_lines(log_file_path)

      ActionCable.server.broadcast('log_monitor', { log: file_lines, type: "new_log" } )
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def added_lines(file_path)
    file_content = File.open(file_path).readlines

    file_content.last(20)
  end
end