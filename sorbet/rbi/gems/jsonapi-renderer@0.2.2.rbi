# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `jsonapi-renderer` gem.
# Please instead update this file by running `bin/tapioca gem jsonapi-renderer`.


# source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#1
module JSONAPI; end

# Represent a recursive set of include directives
# (c.f. http://jsonapi.org/format/#fetching-includes)
#
# Addition to the spec: two wildcards, namely '*' and '**'.
# The former stands for any one level of relationship, and the latter stands
# for any number of levels of relationships.
#
# @example 'posts.*' # => Include related posts, and all the included posts'
#   related resources.
# @example 'posts.**' # => Include related posts, and all the included
#   posts' related resources, and their related resources, recursively.
#
# source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#2
class JSONAPI::IncludeDirective
  # @return [IncludeDirective] a new instance of IncludeDirective
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive.rb#16
  def initialize(include_args, options = T.unsafe(nil)); end

  # @param key [Symbol, String]
  # @return [IncludeDirective, nil]
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive.rb#39
  def [](key); end

  # @param key [Symbol, String]
  # @return [Boolean]
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive.rb#27
  def key?(key); end

  # @return [Array<Symbol>]
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive.rb#33
  def keys; end

  # @return [Hash{Symbol => Hash}]
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive.rb#51
  def to_hash; end

  # @return [String]
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive.rb#58
  def to_string; end

  private

  # @return [Boolean]
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive.rb#78
  def valid?(key); end

  # source://jsonapi-renderer//lib/jsonapi/include_directive.rb#82
  def valid_json_key_name_regex; end
end

# source://jsonapi-renderer//lib/jsonapi/include_directive.rb#74
class JSONAPI::IncludeDirective::InvalidKey < ::StandardError; end

# Utilities to create an IncludeDirective hash from various types of
# inputs.
#
# source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#5
module JSONAPI::IncludeDirective::Parser
  private

  # @api private
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#54
  def deep_merge!(src, ext); end

  # @api private
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#47
  def parse_array(include_array); end

  # @api private
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#40
  def parse_hash(include_hash); end

  # @api private
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#9
  def parse_include_args(include_args); end

  # @api private
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#33
  def parse_path_string(include_path); end

  # @api private
  #
  # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#25
  def parse_string(include_string); end

  class << self
    # @api private
    #
    # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#54
    def deep_merge!(src, ext); end

    # @api private
    #
    # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#47
    def parse_array(include_array); end

    # @api private
    #
    # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#40
    def parse_hash(include_hash); end

    # @api private
    #
    # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#9
    def parse_include_args(include_args); end

    # @api private
    #
    # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#33
    def parse_path_string(include_path); end

    # @api private
    #
    # source://jsonapi-renderer//lib/jsonapi/include_directive/parser.rb#25
    def parse_string(include_string); end
  end
end
