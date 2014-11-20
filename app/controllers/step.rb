require 'delegate'
class Step < SimpleDelegator
  def self.create(controller, step = 'billing_step')
    step.camelize.constantize.new(controller)
  end
  def render_me
    session[:last_step] = step
    render "orders/steps/"+self.class.to_s.underscore
  end
  def move
    if params['go_next']
      target = next_step
    elsif params['go_prev']
      target = prev_step
    else
      raise 'go nowhere'
    end
    Step.create(__getobj__, target)
  end
  def has_input?(column_name)
    inputs.include?(column_name)
  end
  def all_columns
    %w{billing_name shipping_name}
  end
  def first?; false end
  def last?; false end
  def context; step.to_sym end
end

class BillingStep < Step
  def step; 'billing_step' end
  def next_step; 'shipping_step' end
  def first?; true end
  def inputs;%w{billing_name} end
end

class ShippingStep < Step
  def step; 'shipping_step' end
  def next_step; 'confirm_step' end
  def prev_step; 'billing_step' end
  def inputs;%w{shipping_name} end
end

class ConfirmStep <Step
  def step; 'confirm_step' end
  def prev_step; 'shipping_step' end
  def last?; true end
  def inputs;[] end
end
