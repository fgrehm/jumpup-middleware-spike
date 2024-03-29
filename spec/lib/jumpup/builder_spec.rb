require 'spec_helper'

require 'jumpup/runner'
require 'jumpup/builder'

RSpec.describe Jumpup::Builder do
  let(:data) { { :data => [] } }
  let(:instance) { described_class.new }

  # This returns a proc that can be used with the builder
  # that simply appends data to an array in the env.
  def appender_proc(data)
    Proc.new { |env| env[:data] << data }
  end

  context "basic `use`" do
    it "adds items to the stack and make them callable" do
      data = {}
      proc = Proc.new { |env| env[:data] = true }

      instance.use proc
      instance.call(data)

      expect(data[:data]).to eq(true)
    end

    it "is able to add multiple items" do
      data = {}
      proc1 = Proc.new { |env| env[:one] = true }
      proc2 = Proc.new { |env| env[:two] = true }

      instance.use proc1
      instance.use proc2
      instance.call(data)

      expect(data[:one]).to eq(true)
      expect(data[:two]).to eq(true)
    end

    it "is able to add another builder" do
      data  = {}
      proc1 = Proc.new { |env| env[:one] = true }

      # Build the first builder
      one   = described_class.new
      one.use proc1

      # Add it to this builder
      two   = described_class.new
      two.use one

      # Call the 2nd and verify results
      two.call(data)
      expect(data[:one]).to eq(true)
    end

    it "defaults the env to `nil` if not given" do
      result = false
      proc = Proc.new { |env| result = env.nil? }

      instance.use proc
      instance.call

      expect(result).to be_truthy
     end
  end

  context "inserting" do
    it "can insert at an index" do
      instance.use appender_proc(1)
      instance.insert(0, appender_proc(2))
      instance.call(data)

      expect(data[:data]).to eq([2, 1])
    end

    it "can insert next to a previous object" do
      proc2 = appender_proc(2)
      instance.use appender_proc(1)
      instance.use proc2
      instance.insert(proc2, appender_proc(3))
      instance.call(data)

      expect(data[:data]).to eq([1, 3, 2])
    end

    it "can insert before" do
      instance.use appender_proc(1)
      instance.insert_before 0, appender_proc(2)
      instance.call(data)

      expect(data[:data]).to eq([2, 1])
    end

    it "raises an exception if attempting to insert before an invalid object" do
      expect { instance.insert "object", appender_proc(1) }.
        to raise_error(RuntimeError)
    end

    it "can insert after" do
      instance.use appender_proc(1)
      instance.use appender_proc(3)
      instance.insert_after 0, appender_proc(2)
      instance.call(data)

      expect(data[:data]).to eq([1, 2, 3])
    end

    it "raises an exception if attempting to insert after an invalid object" do
      expect { instance.insert_after "object", appender_proc(1) }.
        to raise_error(RuntimeError)
    end
  end

  context "replace" do
    it "can replace an object" do
      proc1 = appender_proc(1)
      proc2 = appender_proc(2)

      instance.use proc1
      instance.replace proc1, proc2
      instance.call(data)

      expect(data[:data]).to eq([2])
    end

    it "can replace by index" do
      proc1 = appender_proc(1)
      proc2 = appender_proc(2)

      instance.use proc1
      instance.replace 0, proc2
      instance.call(data)

      expect(data[:data]).to eq([2])
    end
  end

  context "deleting" do
    it "can delete by object" do
      proc1 = appender_proc(1)

      instance.use proc1
      instance.use appender_proc(2)
      instance.delete proc1
      instance.call(data)

      expect(data[:data]).to eq([2])
    end

    it "can delete by index" do
      proc1 = appender_proc(1)

      instance.use proc1
      instance.use appender_proc(2)
      instance.delete 0
      instance.call(data)

      expect(data[:data]).to eq([2])
    end
  end
end
