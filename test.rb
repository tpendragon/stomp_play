#!/usr/bin/env ruby

require 'stomp'
require 'pry'

class Event
  attr_reader :msg
  def initialize(msg)
    @msg = msg
  end

  def type
    msg.headers['org.fcrepo.jms.eventType']
  end

  def pid
    msg.headers['org.fcrepo.jms.identifier']
  end
end
client = Stomp::Client.new("fedoraAdmin", "secret3", "localhost", 61613)
client.subscribe("/topic/fedora") do |msg|
  event = Event.new(msg)
  puts "#{event.type} called for #{event.pid}"
end
loop do
  sleep(1)
end
