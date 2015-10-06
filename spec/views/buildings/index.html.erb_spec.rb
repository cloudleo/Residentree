require 'rails_helper'

RSpec.describe "buildings/index", type: :view do
  before(:each) do
    assign(:buildings, [
      Building.create!(
        :address => "Address",
        :zip => 1,
        :rating_sum => 2,
        :rating_count => 3
      ),
      Building.create!(
        :address => "Address",
        :zip => 1,
        :rating_sum => 2,
        :rating_count => 3
      )
    ])
  end

  it "renders a list of buildings" do
    render
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
