class JsonFormBuilder
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  require 'ostruct'

  def initialize(question)
    @question = OpenStruct.new(question)
  end

  def render
    content_tag(:div, label_and_input.html_safe, class: "field")
  end

  private

  def label_and_input
    html = []
    html << label_tag(@question.text, @question.text, @question.label_options) + "<br />".html_safe
    html << send(@question.type)
    html.join("\n")
  end

  def radio_button
    html = []
    @question.answers.each do |answer|
      html << label_tag(answer)
      html << send(@question.type + "_tag", @question.text, answer, false, @question.input_options)
    end
    html.join("\n")
  end

  def select
    send(@question.type + "_tag", @question.text, options_for_select(@question.answers), @question.input_options)
  end

  def text_field
    send(@question.type + "_tag", @question.text, nil, @question.input_options)
  end
end