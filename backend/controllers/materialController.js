const Material = require('../models/materialModel.js');

exports.createMaterial = async (req, res) => {
  req.body.quantity = parseInt(req.body.quantity);
  req.body.date = new Date(req.body.date);
  req.body.cost = parseInt(req.body.cost);
  const newMaterial = await Material.create(req.body);
  res.status(201).json({ status: 'success', material: newMaterial });
};

exports.getAllMaterials = async (req, res) => {
  const materials = await Material.find();
  res.status(200).json({ status: 'success', materials });
};
