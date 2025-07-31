// functions/index.js

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(); // تهيئة Firebase Admin SDK

// هذه الدالة ستُشغل تلقائياً عند تسجيل مستخدم جديد في Firebase Authentication
exports.sendWelcomeNotification = functions.auth.user().onCreate(async (user) => {
    const uid = user.uid; // معرّف المستخدم الجديد
    const email = user.email; // بريد المستخدم الجديد (إذا كان متوفراً)
    console.log(`New user signed up: ${uid}, Email: ${email}`);

    // **هام جداً: الحصول على الـ FCM Token الخاص بهذا المستخدم**
    // هذا الجزء يفترض أنكِ تقومين بتخزين الـ FCM Token لكل مستخدم في Firestore
    // عندما يسجل دخوله أو ينشئ حساباً جديداً في تطبيق Flutter.
    // يجب أن يكون لديكِ collection في Firestore اسمها 'users'
    // وكل مستند (document) في هذه الـ collection معرّفه (doc.id) هو الـ UID الخاص بالمستخدم
    // ويحتوي هذا المستند على حقل اسمه 'fcmToken'.

    let fcmToken = null;
    try {
        const userDoc = await admin.firestore().collection('users').doc(uid).get();
        if (userDoc.exists) {
            fcmToken = userDoc.data()?.fcmToken;
        }
    } catch (error) {
        console.error('Error fetching FCM token from Firestore:', error);
        return null; // لا يمكن إكمال العملية بدون توكن
    }

    if (!fcmToken) {
        console.log(`No FCM token found for user ${uid}. Cannot send welcome notification.`);
        return null; // لا يمكن إرسال الإشعار بدون توكن
    }

    // إعداد رسالة الإشعار
    const payload = {
        notification: {
            title: 'مرحباً بك في MechPro!',
            body: 'لا تفوت عروضنا الحصرية المتاحة الآن! انقر هنا للاستكشاف.',
        },
        data: {
            type: 'welcome_offer', // هذا لبيانات إضافية يمكن لتطبيق Flutter قراءتها
            screen: 'offers_page' // مثال: لتوجيه المستخدم لصفحة العروض عند النقر
        },
    };

    // إرسال الإشعار
    try {
        const response = await admin.messaging().sendToDevice(fcmToken, payload);
        console.log('Successfully sent welcome message:', response);
        return null; // مهم إرجاع null أو Promise.resolve() للدوال غير المتزامنة
    } catch (error) {
        console.error('Error sending welcome message:', error);
        return null;
    }
});