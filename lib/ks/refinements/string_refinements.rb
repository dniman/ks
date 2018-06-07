module KS
  module StringRefinements
    refine String do
      def underscore
        new_string = gsub("::", "_")
        new_string.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
        new_string.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
        new_string.gsub!(/[[:space:]]|\-/, '\1_\2')
        new_string.downcase!
        self.class.new new_string
      end
    end
  end
end