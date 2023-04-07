module Main
  module Action
    class Base < Interlinker::Action::Base
      before :set_headers

      private

      def set_headers(req, res)
        res.headers['Content-Type'] = 'application/json'
      end
    end
  end
end
