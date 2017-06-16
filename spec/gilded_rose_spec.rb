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
      it "increases in quality by 1 the older it gets" do
        items = [Item.new("Aged Brie", 10, 15)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to change{ items[0].quality}.by 1
      end

      it "increases in quality by 2 after its sell in value has reached 0" do
        items = [Item.new("Aged Brie", 0, 10)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to change{ items[0].quality}.by 2
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

  context "Backstage passes" do
    describe "#update_quality" do
      it "increases in quality by 1 when its sell in value is more than 10 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to change{ items[0].quality}.by 1
      end

      it "increases in quality by 2 when its sell in value is 10 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 25)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to change{ items[0].quality}.by 2
      end

      it "increases in quality by 3 when its sell in value is 5 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 35)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to change{ items[0].quality}.by 3
      end

      it "quality drops to 0 after the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end
  end

  context "The Quality of an item is never more than 50" do
    describe "#update_quality" do
      it "Aged Brie (sell_in value is still counted)" do
        items = [Item.new("Aged Brie", 10, 50)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to_not change{ items[0].quality}
        expect { inventory.update_quality }.to change{ items[0].sell_in}.by -1
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
=begin
      it "All the other items" do
        items = [Item.new("Random item", 10, 50)]
        inventory = GildedRose.new(items)
        expect { inventory.update_quality }.to_not change{ items[0].quality}
      end
=end
    end
  end

end
