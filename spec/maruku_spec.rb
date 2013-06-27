require 'rspec'
require 'maruku'
require 'pry'

describe Maruku do
  let(:result) { Maruku.new(input).to_html }

  describe "handling attributes" do
    context "for block-level image elements" do
      let(:input) { "![#{alt_text}](url)" }
      let(:alt_text) { nil }

      context "with apostraphes" do
        let(:alt_text) { "Maruku's awesome" }

        it "does not omit the apostraphe(s) from the resulting HTML" do
          result.should == %Q(<p><img src="url" alt="Maruku&#x2019;s awesome" /></p>)
        end
      end

      context "with quotes" do
        let(:alt_text) { '"Hello!" "Goodbye!"' }

        it "includes the quotation marks (properly escaped) in the resulting HTML" do
          result.should == %Q(<p><img src="url" alt="&#x201C;Hello!&#x201D; &#x201C;Goodbye!&#x201D;" /></p>)
        end
      end

      context "with HTML" do
        let(:alt_text) { '<p><em>I</em> am <strong>HTML</strong>.</p>' }

        it "basically ignores the HTML" do
          result.should == %Q(<p><img src="url" alt="I am HTML." /></p>)
        end
      end
    end
  end
end
