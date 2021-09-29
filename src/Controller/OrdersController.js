import { response } from 'express';
import pool from '../Database/mysql';


export const addNewOrders = async (req, res = response ) => {

    try {

        const { uidAddress, total, typePayment,  products } = req.body;

        const orderdb = await pool.query('INSERT INTO orders (client_id, address_id, amount, pay_type) VALUES (?,?,?,?)', [ req.uid, uidAddress, total, typePayment ]);

        products.forEach(o => {
             pool.query('INSERT INTO orderDetails (order_id, product_id, quantity, price) VALUES (?,?,?,?)', [ orderdb.insertId, o.uidProduct, o.quantity, o.quantity * o.price ]);
        });

        res.json({
            resp: true,
            msg : 'New Order added successfully'
        });

    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

export const getOrdersByStatus = async (req, res = response ) => {

    try {

        const ordersdb = await pool.query(`CALL SP_ALL_ORDERS_STATUS(?);`, [ req.params.statusOrder ]);

        res.json({
            resp: true,
            msg : 'Orders by ' + req.params.statusOrder,
            ordersResponse : ordersdb[0]
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

export const getDetailsOrderById = async ( req, res = response ) => {

    try {

        const detailOrderdb = await pool.query(`CALL SP_ORDER_DETAILS(?);`, [ req.params.idOrderDetails ]);

        res.json({
            resp: true,
            msg : 'Order details by ' + req.params.idOrderDetails,
            detailsOrder: detailOrderdb[0]
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

export const updateStatusToDispatched = async ( req, res = response ) => {

    try {

        const { idDelivery, idOrder } = req.body;

        await pool.query('UPDATE orders SET status = ?, delivery_id = ? WHERE id = ?', [ 'DISPATCHED', idDelivery, idOrder ]);

        res.json({
            resp: true,
            msg : 'Order DISPATCHED'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

export const getOrdersByDelivery = async ( req, res = response ) => {

    try {

        const ordersDeliverydb = await pool.query(`CALL SP_ORDERS_BY_DELIVERY(?,?);`, [ req.uid, req.params.statusOrder ]);

        res.json({
            resp: true,
            msg : 'All Orders By Delivery',
            ordersResponse : ordersDeliverydb[0]
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

export const updateStatusToOntheWay = async ( req, res = response ) => {

    try {

        const { latitude, longitude } = req.body;

        await pool.query('UPDATE orders SET status = ?, latitude = ?, longitude = ? WHERE id = ?', ['ON WAY', latitude, longitude, req.params.idOrder ]);

        res.json({
            resp: true,
            msg : 'ON WAY'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

export const updateStatusToDelivered = async ( req, res = response ) => {

    try {

        await pool.query('UPDATE orders SET status = ? WHERE id = ?', ['DELIVERED', req.params.idOrder ]);

        res.json({
            resp: true,
            msg : 'ORDER DELIVERED'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}