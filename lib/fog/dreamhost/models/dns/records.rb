require 'fog/core/collection'
require 'fog/dreamhost/models/dns/record'

module Fog
  module DNS
    class Dreamhost

      class Records < Fog::Collection

        model Fog::DNS::Dreamhost::Record

        def all(filter = {})
          clear
          if filter[:zone]
            data = connection.list_records.body['data'].find_all { |r| r['zone'] == filter[:zone] }
          else
            data = connection.list_records.body['data']
          end
          load(data)
        end

        def get(record_name)
          data = connection.get_record(record_name).body['data'].find { |r| r['record'] == record_name }
          new(data)
        rescue Excon::Errors::NotFound
          nil
        end

      end

    end
  end
end
