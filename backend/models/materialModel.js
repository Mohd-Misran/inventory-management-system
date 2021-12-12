const mongoose = require('mongoose');

const materialSchema = new mongoose.Schema({
  partName: {
    type: String,
    required: [true, 'Part name is required.'],
    trim: true,
  },
  quantity: {
    type: Number,
    required: [true, 'Quantity is required.'],
    min: 1,
  },
  description: {
    type: String,
    trim: true,
  },
  date: { type: Date, required: [true, 'Date is required.'] },
  vendor: String,
  billNo: { type: Number, required: [true, 'Bill number is required.'] },
  cost: { type: Number, required: [true, 'Cost is required.'] },
});

const Material = mongoose.model('Material', materialSchema);

module.exports = Material;
