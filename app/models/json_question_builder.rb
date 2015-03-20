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
    html_class << " hidden dependent_#{@question.id.to_i}" if @question.order.is_a?(Float)
    content_tag(:div, label_and_input.html_safe, class: html_class, data: {id: @question.id})
  end

  private

  def label_options
    @label_options ||= @question.label_options || {}
  end

  def input_options
    if @question.answers && @question.answers.first.is_a?(Hash)
      @input_options = (@question.input_options || {}).merge!({:"data-has-dependents" => true})
    else
      @input_options = @question.input_options || {}
    end
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
      answer_text = answer.is_a?(Hash) ? answer.keys.first.to_s : answer
      input_options.merge!({:"data-dependent" => answer.values.first}) if answer.is_a?(Hash)

      # This second .merge is not working!!


      html << label_tag(@question.text + "_" + answer_text, answer_text)
      html << send(@question.type + "_tag", @question.text, answer_text, false, input_options)
    end
    html.join("\n")
  end

  def select
    # add value of hash as data-dependent attribute to option
    answers = @question.answers.first.is_a?(Hash) ? @question.answers.map{|v| [v.keys.first, v.keys.first, {:"data-dependent" => v.values.first}]} : @question.answers
    send(@question.type + "_tag", @question.text, options_for_select(answers), input_options)
  end

  def text_field
    send(@question.type + "_tag", @question.text, nil, input_options)
  end
end