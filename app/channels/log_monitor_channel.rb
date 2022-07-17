class LogMonitorChannel < ApplicationCable::Channel
  def subscribed
    stream_from "log_monitor" 

    log_file_path = Rails.root.join('log/development.log').to_s

    ActionCable.server.broadcast('log_monitor', { log: added_lines(log_file_path), type: "new_log" } )

    Filewatcher.new([log_file_path]).watch do |_file_path, event_type|
      next unless event_type.to_s.eql?('updated')

      ActionCable.server.broadcast('log_monitor', { log: added_lines(log_file_path), type: "new_log" } )
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def added_lines(file_path)
    `tail -n 20 #{file_path}`
  end
end