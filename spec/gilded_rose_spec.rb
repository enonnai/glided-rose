require 'spec_helper'
require_relative '../gilded_rose.rb'

describe GildedRose do

  context "Any item except 'Aged Brie', 'Sulfura, hand of Ragnaros' and 'Backstage passes'" do
    describe "#update_quality" do

      it "does not change the name" do
        items = [Item.new("foo", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq "foo"
      end

      it "changes the sell in value by -1" do
        items = [Item.new("foo", 10, 10)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to change{ items[0].sell_in}.by -1
      end

      it "changes the quality value by -1" do
        items = [Item.new("foo", 10, 10)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to change{ items[0].quality}.by -1
      end

      it "changes the quality value by -2 when item passes the sell by date" do
        items = [Item.new("foo", 0, 3)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to change{ items[0].quality}.by -2
      end

      it "the quality of an item is never negative" do
        items = [Item.new("foo", 2, 1)]
        inventory = GildedRose.new(items)
        inventory.update_quality
        expect { inventory.update_quality }.to_not change{ items[0].quality}
      end
    end
  end

  context "Aged Brie" do
    describe "#update_quality" do
      it "increases in quality the older it gets" do
        items = [Item.new("Aged Brie", 10, 15)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to change{ items[0].quality}.by 1
      end

      it "doesn't increase in quality beyond 50" do
        items = [Item.new("Aged Brie", 10, 50)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to_not change{ items[0].quality}
      end
    end
  end

  context "Sulfuras" do
    describe "#update_quality" do
      it "never has to be sold" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 50)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to_not change{ items[0].sell_in}
      end

      it "never decreseas in quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 50)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to_not change{ items[0].quality}
      end
    end
  end

  context "The Quality of an item is never more than 50" do
    describe "#update_quality" do
      it "Aged Brie" do
        items = [Item.new("Aged Brie", 10, 50)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to_not change{ items[0].quality}
      end

      it "Backstage passes" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to_not change{ items[0].quality}
      end

      it "Sulfuras" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 50)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to_not change{ items[0].quality}
      end
    end
  end

end
