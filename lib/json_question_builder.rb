class JsonQuestionBuilder
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  require 'ostruct'

  # Requirements:
  #   accept label and input html options
  #   accept array of strings and hashes for answers 

  def initialize(question)
    @question = OpenStruct.new(question)
  end

  def render
    html_class = "field"
    html_class << " hidden dependent_#{@question.id.to_i}" if hidden?
    content_tag(:div, label_and_input.html_safe, class: html_class, data: {id: @question.id})
  end

  private

  def hidden?
    @question.id.is_a? Float
  end

  def has_dependents?
    @question.answers && @question.answers.any?{|a| a.is_a? Hash}
  end

  def label_options
    @label_options ||= @question.label_options || {}
  end

  def input_options
    @input_options = @question.input_options || {}
    @input_options.merge!({:"data-has-dependents" => true}) if has_dependents?
    @input_options.merge!({disabled: true}) if hidden?
    @input_options
  end

  def label_and_input
    html = []
    html << label_tag(@question.text, @question.text, label_options) + "<br />".html_safe
    html << send(@question.type)
    html.join("\n")
  end

  def radio_button
    html = []
    @question.answers.each do |answer|
      answer_text = answer.is_a?(Hash) ? answer.keys.first.to_s : answer.to_s
      options = input_options
      options = input_options.merge!({:"data-dependent" => answer.values.first}) if answer.is_a?(Hash)
      html << send(@question.type + "_tag", @question.text, answer_text, false, options)
      html << label_tag(@question.text + "_" + answer_text, answer_text)
    end
    html.join("\n")
  end

  def select
    # add value of hash as data-dependent attribute to option
    answers = has_dependents? ? @question.answers.map{|v| [v.keys.first, v.keys.first, {:"data-dependent" => v.values.first}]} : @question.answers
    send(@question.type + "_tag", @question.text, options_for_select(answers), input_options)
  end

  def text_field
    send(@question.type + "_tag", @question.text, nil, input_options)
  end

  def check_box
    radio_button
  end

  def date_field
  end

  def email_field
  end

  def file_field
  end

  def number_field_tag
  end

end