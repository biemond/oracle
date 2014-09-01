#!/usr/bin/env rspec

require 'spec_helper'

oracle_exec = Puppet::Type.type(:oracle_exec)

describe oracle_exec do

  let(:attribute_class) {  @class.attrclass(attribute_name) }
  let(:attribute) {@resource.property(attribute_name)}


  before :each do
    @class = oracle_exec
    @provider = double 'provider'
    allow(@provider).to receive(:name).and_return(:sqlplus)
    allow(Puppet::Type::Oracle_exec).to receive(:defaultprovider).and_return @provider
    class Puppet::Type::Oracle_exec; def self.oratab; [:sid => 'TEST']; end; end
    @resource = @class.new({:title  => 'show_all'})
  end

  describe ':statement' do

    it 'should have :statement property' do
      expect(@class.properties.map(&:name)).to include(:statement)
    end
  end

  describe ':timeout' do

    it 'should have :timeout attribute' do
      expect(@class.parameters).to include(:timeout)
    end
  end


  describe ':logoutput' do

    it 'should have :logoutput attribute' do
     expect(@class.parameters).to include(:logoutput)
    end
  end

  describe ':username' do

    it 'should have :username attribute' do
     expect(@class.parameters).to include(:username)
    end
  end

  describe ':password' do

    it 'should have :password attribute' do
     expect(@class.parameters).to include(:password)
    end
  end


end