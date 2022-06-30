RSpec.describe 'Rails.application', type: :routing do
  it "fails if application does not have valid routes" do
    expect(Rails.application).to have_no_unused_routes
  end
end
