import { Router } from 'express';

import * as product from '../Controller/ProductController';
import { upLoadsProducts } from '../Lib/Multer';
import { verifyToken } from '../Middleware/ValidateToken';

const router = Router();


router.post('/add-new-products', [ verifyToken, upLoadsProducts.array('image') ], product.addNewProduct);
router.get('/get-products-top-home', verifyToken, product.getProductsTopHome);
router.get('/get-images-products/:id', verifyToken, product.getImagesProducts );
router.get('/search-product-for-name/:nameProduct', verifyToken, product.searchProductForName );
router.get('/search-product-for-category/:idCategory', verifyToken, product.searchProductsForCategory );
router.get('/list-porducts-admin', verifyToken, product.listProductsAdmin );
router.put('/update-status-product', verifyToken, product.updateStatusProduct);
router.delete('/delete-product/:idProduct', verifyToken, product.deleteProduct);


export default router;