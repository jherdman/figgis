# Notes

## Models

### Project

- has many Metric
- has a `name`, required

### Metric

- has many Data
- has a `description`, required
- has a `name`, required
- has an `x_axis_label`, required
- has an `x_axis_type`, required
- has a `y_axis_label`, required
- has a `y_axis_type`, required

### Datum

- has an `x_value`, required
- has a `y_value`, required
