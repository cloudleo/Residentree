require 'rails_helper'

RSpec.describe "buildings/edit", type: :view do
  before(:each) do
    @building = assign(:building, Building.create!(
      :address => "MyString",
      :zip => 1,
      :rating_sum => 1,
      :rating_count => 1
    ))
  end

  it "renders the edit building form" do
    render

    assert_select "form[action=?][method=?]", building_path(@building), "post" do

      assert_select "input#building_address[name=?]", "building[address]"

      assert_select "input#building_zip[name=?]", "building[zip]"

      assert_select "input#building_rating_sum[name=?]", "building[rating_sum]"

      assert_select "input#building_rating_count[name=?]", "building[rating_count]"
    end
  end
end
