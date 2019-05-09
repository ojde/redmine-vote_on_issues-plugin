require 'query'

class VoiQueryColumn < QueryColumn
=begin
  attr_accessor :name, :sortable, :groupable, :default_order
  include Redmine::I18n

  def initialize(name, options={})
    self.name = name
    self.sortable = options[:sortable]
    self.groupable = options[:groupable] || false
    if groupable == true
      self.groupable = name.to_s
    end
    self.default_order = options[:default_order]
    @inline = options.key?(:inline) ? options[:inline] : true
    @caption_key = options[:caption] || "field_#{name}".to_sym
    @frozen = options[:frozen]
  end

  def caption
    @caption_key.is_a?(Symbol) ? l(@caption_key) : @caption_key
  end

  # Returns true if the column is sortable, otherwise false
  def sortable?
    !@sortable.nil?
  end

  def sortable
    @sortable.is_a?(Proc) ? @sortable.call : @sortable
  end

  def inline?
    @inline
  end

  def frozen?
    @frozen
  end
=end
  def value(object)
    object.send name, object
  end

  def value_object(object)
    object.send name, object
  end
=begin
  def css_classes
    name
  end
=end
end
