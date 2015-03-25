class JsonQuestionBuilder
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  require 'ostruct'

  # Requirements:
  #   accept label and input html options
  #   accept array of strings and hashes for answers 

  def initialize(question, form_object)
    @question = OpenStruct.new(question)
    @form_object ||= form_object
    @input_options ||= input_options
    @label_options ||= @question.label_options || {}
  end

  def render
    html_class = "field"
    html_class << " hidden dependent_#{@question.id.to_i}" if hidden?
    content_tag(:div, label_and_input.html_safe, class: html_class, data: {id: @question.id})
  end

  private

  def label_and_input
    html = []
    hint = (@question.hint.present? ? ("<span class='json-question-hint'>"+@question.hint+"</span>") : "")
    html << @form_object.label(@question.text, @label_options) + (hint + "<br />").html_safe
    html << send(@question.type)
    html.join("\n")
  end

  def hidden?
    @question.id.is_a? Float
  end

  def has_dependents?
    @question.answers && @question.answers.any?{|a| a.is_a? Hash}
  end

  def input_options
    options = @question.input_options || {}
    options.merge!({:"data-has-dependents" => true}) if has_dependents?
    options.merge!({disabled: true}) if hidden?
    options
  end

  def collection_tag(multiple=false)
    # radio_button_tag(name, value, checked = false, options = {})
    # check_box_tag(name, value = "1", checked = false, options = {})

    html = []
    @question.answers.each do |answer|
      answer_text = answer.is_a?(Hash) ? answer.keys.first.to_s : answer.to_s
      options = @input_options.merge({id: sanitize_to_id(scope_text+answer_text.downcase)})
      options.merge!({:"data-dependent" => answer.values.first}) if answer.is_a?(Hash)

      html << send(@question.type + "_tag", (multiple ? scope_text+'[]' : scope_text), answer_text, false, options)
      html << label_tag(sanitize_to_id(scope_text+answer_text.downcase), answer_text)
    end
    html.join("\n")
  end

  def radio_button
    collection_tag
  end

  def check_box
    collection_tag(true)
  end

  def select
    answers = @question.answers.map{|a| (a.is_a?(Hash) ? [a.keys.first, a.keys.first, {:"data-dependent" => a.values.first}] : [a])}
    @form_object.send(@question.type, @question.text, answers, {}, @input_options)
    # send(@question.type + "_tag", scope_text, options_for_select(answers), input_options)
  end

  def text_field
    @form_object.send(@question.type, @question.text, @input_options)
  end

  def date_field
  end

  def email_field
  end

  def file_field
  end

  def number_field_tag
  end

  # http://apidock.com/rails/ActionView/Helpers/FormTagHelper/sanitize_to_id
  def sanitize_to_id(text)
    text.to_s.delete(']').gsub(/[^-a-zA-Z0-9:.]/, "_")
  end

  def scope_text
    @form_object.object_name + "[#{@question.text}]"
  end

end