require 'spec_helper'
require_relative '../gilded_rose.rb'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "changes the sell in date by -1" do
      items = [Item.new("foo", 10, 10)]
      inventory = GildedRose.new(items)
      expect { inventory.update_quality }.to change{ items[0].sell_in}.by -1
    end


  end

end
