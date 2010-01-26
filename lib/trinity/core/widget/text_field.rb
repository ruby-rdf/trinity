class Trinity::Widget
  ##
  # Text field widget.
  class TextField < Trinity::Widget
    ##
    # @param  [Builder] html
    # @return [void]
    def content(html)
      if editable?
        html.input(:type => :text, :name => predicate.to_s, :value => object.value.to_s)
      else
        html.text(object.value.to_s)
      end
    end
  end
end
