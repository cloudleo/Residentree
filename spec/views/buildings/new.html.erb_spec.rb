require 'rails_helper'

RSpec.describe "buildings/new", type: :view do
  before(:each) do
    assign(:building, Building.new(
      :address => "MyString",
      :zip => 1,
      :rating_sum => 1,
      :rating_count => 1
    ))
  end

  it "renders new building form" do
    render

    assert_select "form[action=?][method=?]", buildings_path, "post" do

      assert_select "input#building_address[name=?]", "building[address]"

      assert_select "input#building_zip[name=?]", "building[zip]"

      assert_select "input#building_rating_sum[name=?]", "building[rating_sum]"

      assert_select "input#building_rating_count[name=?]", "building[rating_count]"
    end
  end
end
