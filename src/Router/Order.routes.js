import { Router } from 'express'; 
import * as orders from '../Controller/OrdersController';
import * as client from '../Controller/ClientController';
import { verifyToken } from '../Middleware/ValidateToken';

const router = Router();


router.post('/add-new-orders', verifyToken, orders.addNewOrders );
router.get('/get-orders-by-status/:statusOrder', verifyToken, orders.getOrdersByStatus );
router.get('/get-details-order-by-id/:idOrderDetails', verifyToken, orders.getDetailsOrderById );
router.put('/update-status-order-dispatched', verifyToken, orders.updateStatusToDispatched );
router.get('/get-all-orders-by-delivery/:statusOrder', verifyToken, orders.getOrdersByDelivery );
router.put('/update-status-order-on-way/:idOrder', verifyToken, orders.updateStatusToOntheWay );
router.put('/update-status-order-delivered/:idOrder', verifyToken, orders.updateStatusToDelivered );

router.get('/get-list-orders-for-client', verifyToken, client.getListOrdersForClient);


export default router;