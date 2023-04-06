# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it "Email can't be blank" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("não pode ficar em branco")
  end
end
