# frozen_string_literal: true

module ApplicationHelper
  def text_with_icon(icon, text)
    capture do
      concat content_tag(:i, nil, class: icon)
      concat text
    end
  end

  def button(name, target, type = 'primary', **options)
    options ||= {}
    options[:class] = merge_classes(options[:class] || '', "btn btn-#{type}")
    link_to name, target, **options
  end

  def merge_classes(origin, new)
    (origin.split(' ') + new.split(' ')).uniq.join(' ')
  end
end
