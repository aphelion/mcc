module BuildsHelper
  STATUS_HASH = {
      passed: 'success',
      failed: 'danger'
  }.with_indifferent_access

  def build_card_class(build)
    color = build_status_css_color(build.status)
    color ? 'card-' + color : ''
  end

  def build_status_label_class(build)
    color = build_status_css_color(build.status)
    'label-' + (color ? color : 'default')
  end

  def build_status_css_color(status)
    STATUS_HASH[status]
  end

  def build_status_class(build)
    'build-status-' + build.status.dasherize
  end
end
