require 'yaml'

module Repokeeper
  class Config
    HOME_DIR = File.expand_path('../..', __dir__)
    CONFIG_DIR = File.join(HOME_DIR, 'config')
    DEFAULT_CONFIG = File.join(CONFIG_DIR, 'default.yml')

    def initialize(hash)
      @config = hash
    end

    def for(klass)
      key = klass.name.split('::').last
                 .gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
      @config[key]
    end

    def self.read(file_path = nil)
      config_file = read_configuration_file(file_path)
      config = merge_hashes(default_configuration, config_file)
      new(config)
    end

    def self.default_configuration
      read_configuration_file(DEFAULT_CONFIG)
    end

    def self.read_configuration_file(file_path)
      return {} unless file_path
      YAML.safe_load_file(file_path, permitted_classes: [], permitted_symbols: [], aliases: false)
    end
    private_class_method :read_configuration_file

    def self.merge_hashes(hash1, hash2)
      hash1.merge(hash2) do |_, oldval, newval|
        old_hash = oldval || {}
        new_hash = newval || {}

        old_hash.merge(new_hash)
      end
    end
    private_class_method :merge_hashes
  end
end
