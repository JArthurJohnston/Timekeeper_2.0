module Api

  class StoryCardsController < ApiController

    def show
      card = StoryCard.find_by(id: params[:id])
      unless card.nil?
        render json: StoryCard.find(params[:id])
      else
        head :not_found
      end
    end

    private

      def find_card
        card = StoryCard::NULL
        begin
          card =  StoryCard.find
        rescue ActiveRecord::RecordNotFound
          head :not_found
        end
        card
      end
  end

end
