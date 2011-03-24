module Readability
  class Document
    # This is basically the "content" method, shortened to just pull the top candidate element.
    def get_best_candidate(remove_unlikely_candidates = :default)
      @remove_unlikely_candidates = false if remove_unlikely_candidates == false

      @html.css("script, style").each { |i| i.remove }

      remove_unlikely_candidates! if @remove_unlikely_candidates
      transform_misused_divs_into_paragraphs!
      candidates = score_paragraphs(options[:min_text_length])
      best_candidate = select_best_candidate(candidates)
      best_candidate[:elem]
    rescue NoMethodError
      nil
    end
  end
end
