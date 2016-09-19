require "spec_helper"

describe I18n::Backend::Callbacks do
  let(:wrapped) do
    instance_double(
      I18n::Backend::Simple,
      available_locales: [:en],
      translate: original
    )
  end
  let(:key) { "hello" }
  let(:original) { "foo" }
  let(:before) { nil }
  let(:after) { nil }

  before do
    I18n.backend = described_class.new(wrapped, before: before, after: after)
  end
  after { I18n.backend = nil }

  context "with a pre hook defined" do
    let(:before) do
      ->(locale, key, options = {}) { [:fr, key, options] }
    end

    it "allows pre-processing of I18n.t calls" do
      I18n.t(key)

      expect(wrapped).to have_received(:translate).with(:fr, key, {})
    end
  end

  context "with a post hook defined" do
    let(:after) do
      ->(locale, key, options = {}, result) { "#{key} -> #{result}" }
    end

    it "allows post-processing of I18n.t calls" do
      expect(I18n.t(key)).to eq("#{key} -> #{original}")
    end
  end

  context "without hooks defined" do
    it "proxies to the backend" do
      expect(I18n.t("hello")).to eq(original)
    end
  end
end
