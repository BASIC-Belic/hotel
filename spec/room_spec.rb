require_relative 'spec_helper'

describe 'Room' do
  before do
    @room = Hotel::Room.new()
  end

  let(:one_reservation_added) {
    @room.add_reservation(Hotel::Reservation.new("13/12/2018", "15/12/2018", 1))
    @room.reservations }

  let(:another_reservation_added) {
    @room.add_reservation(Hotel::Reservation.new("16/12/2018", "18/12/2018", 2))
    @room.reservations }

  let(:false_available) {
    @room.add_reservation(Hotel::Reservation.new("13/12/2018", "15/12/2018", 1))
    range = (Date.parse("13/12/2018")..Date.parse("15/12/2018")).to_a
    @room.is_available?(range)
  }

  let(:true_available) {
    @room.add_reservation(Hotel::Reservation.new("13/12/2018", "15/12/2018", 1))
    range = (Date.parse("19/12/2018")..Date.parse("20/12/2018")).to_a
    @room.is_available?(range)
  }

  describe 'initialize' do

    it 'will initialize on instance of a room' do
      expect(@room).must_be_instance_of Hotel::Room
    end

    it 'will initialize one new room with a room_number 1-20' do
      expect((1..20).include?(@room.room_number)).must_equal true
    end

    it 'is set up for specific attributes and data types' do
      [:reservations, :room_number].each do |prop|
        expect(@room).must_respond_to prop
      end

      expect(@room.reservations).must_be_kind_of Array
      expect(@room.reservations).must_be_empty
      expect(@room.room_number).must_be_kind_of Integer
    end

  end



  describe 'add_reservation' do

    it 'raise error if passed in value is not a reservation object' do

      expect{
        room = Hotel::Room.new()
        room.add_reservation("AB23246")}.must_raise ArgumentError

      end

      it 'will increment the reservations by one' do

        expect(@room.reservations.length).must_equal 0
        expect(one_reservation_added.length).must_equal 1
        expect(another_reservation_added.length).must_equal 2
      end


    end

    describe 'is_available?' do

      it 'will return true if date present in @reservations' do
        expect(true_available).must_equal true
      end

      it 'will return false if date not present @reservations' do
        expect(false_available).must_equal false
      end

    end



  end
