class Trinity::Widget
  ##
  # Text area widget.
  class TextArea < Trinity::Widget
    ##
    # @param  [Markaby::Builder] html
    # @return [void]
    def content(html)
      object = self.object
      if editable?
        html.textarea(:name => predicate.to_s) { html.text object.value.to_s }
      else
        html.text(object.value.to_s)
      end
    end
  end
end
