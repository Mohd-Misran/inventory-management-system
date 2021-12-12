const express = require('express');

const materialController = require('../controllers/materialController.js');

const router = express.Router();

router
  .route('/')
  .get(materialController.getAllMaterials)
  .post(materialController.createMaterial);

module.exports = router;
