module Refinery
  module Calendar
    class CoreCalendar < ActiveRecord::Base
      self.table_name = 'refinery_calendar_core_calendars'

      attr_accessor :entries
      attr_writer :event_source

      def initialize(attrs = {}, options = {})
        super(attrs, options)
        @entries = []
      end

      def title
        Refinery::Calendar.title
      end

      def new_event(*args)
        event_source.call(*args).tap do |e|
          e.calendar = self
        end
      end

      def add_entry(entry)
        @entries << entry
      end

      def find_entry(id)
        idx = @entries.index { |e| id == e.id }
        return nil if idx.nil?
        @entries[idx]
      end

      def entries
        @entries.sort_by { |e| e.starts }
      end

      class << self
        def fetch(app)
          find_by_app(app)
        end
      end

      private

      def event_source
        @event_source ||= Event.public_method(:new)
      end
    end
  end
end
