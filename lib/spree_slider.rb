require 'spree_core'
require 'spree_slider/engine'

module SpreeSlider

  #
  #  The slide groups... very simple (and dirty) at the moment:
  #  You can add support for multiple sliders, by creating an intializer with the following content.
  #  Maybe in the future we could add a slider_groups table
  #
  #  SpreeSlider.config do |c|
  #    c.slide_groups = {
  #      { id: 1, name: :home, text: "Homepage" },
  #      { id: 2, name: :side, text: "Side slider" }
  #    }
  #  end 
  #
  #  When empty no slide group selection is given
  #
  mattr_accessor :slide_groups
  @@slide_groups = []

  def self.group_id_for_name( name )
    group = slide_groups.find{|g|g[:name].to_s==name.to_s}
    group ? group[:id]  : nil
  end


  def self.config
    yield self
  end  

end
