# 🗡️ Reputation System - FiveM

سیستم اعتباردهی حرفه‌ای برای سرور FiveM مشابه Trust Factor در CS:GO.

## ✨ ویژگی‌ها

- ✅ 10 سطح مختلف از Beginner تا Expert با رنگ‌های متفاوت
- ✅ UI فارسی با Progress Bar و رنگ‌بندی خودکار
- ✅ بن خودکار وقتی Trust Factor پایین می‌آید
- ✅ دستورات ادمین برای مدیریت Trust Factor
- ✅ دیتابیس برای ذخیره‌سازی دائمی
- ✅ سیستم لاگ برای ثبت تمام تغییرات

## 📋 نیازمندی‌ها

- `ox_lib` - برای notifications
- `mysql-async` یا `oxmysql` - برای دیتابیس

## 🚀 نصب

1. فولدر را در `resources` قرار دهید

2. در `server.cfg` اضافه کنید:

```cfg
ensure ox_lib
ensure mysql-async
ensure reputation
```

3. سرور را ریستارت کنید

## 📖 دستورات

### دستورات عمومی

- `/checktrust` - نمایش Trust Factor خود
- `F3` - تغییر حالت نمایش UI

### دستورات ادمین

- `/addtrust [id] [amount] [reason]` - افزودن Trust Factor
- `/removetrust [id] [amount] [reason]` - کم کردن Trust Factor  
- `/settrust [id] [value]` - تنظیم Trust Factor
- `/toptrust` - لیست 10 پلیر برتر (فقط ادمین)
- `/leaderboard` - لیست 10 پلیر برتر (برای همه)

## ⚙️ تنظیمات

در فایل `config.lua` می‌توانید تنظیمات زیر را تغییر دهید:

- `Config.DefaultTrustFactor` - Trust Factor پیش‌فرض (500)
- `Config.BanThreshold` - حد بن شدن خودکار (50)
- `Config.MaxTrustFactor` - حداکثر Trust Factor (1000)
- `Config.TrustFactorLevels` - سطوح مختلف Trust Factor

## 🎨 سطوح Trust Factor

| سطح | بازه | رنگ |
|-----|------|-----|
| Expert | 950-1000 | طلایی |
| Master | 850-949 | قرمز |
| Legendary | 700-849 | بنفش |
| Elite | 600-699 | فیروزه‌ای |
| Veteran | 500-599 | سبز روشن |
| Experienced | 400-499 | سبز |
| Competent | 300-399 | آبی روشن |
| Novice | 200-299 | خاکستری |
| Beginner | 100-199 | نارنجی |
| Suspicious | 0-99 | قرمز (خطرناک) |

## 🎮 مثال استفاده

```
# افزودن Trust Factor
/addtrust 1 50 Helping other players

# کم کردن Trust Factor
/removetrust 1 30 RDM

# تنظیم Trust Factor
/settrust 1 750

# مشاهده Trust Factor خود
/checktrust
```

## 📝 سیستم پنالتی

| تخلف | پنالتی |
|------|--------|
| RDM | -30 |
| VDM | -40 |
| FAILRP | -35 |
| CHEATING | -100 |

## 🎁 پاداش‌ها

| عمل | پاداش |
|-----|-------|
| HELPING | +10 |
| GOODBEHAVIOR | +5 |
| REPORTER | +15 |

## 🔧 یکپارچه‌سازی

این اسکریپت به صورت **Standalone** ساخته شده و از Ace Permissions استفاده می‌کند.

برای یکپارچه‌سازی با ESX یا QBCore، فایل‌های `esx_integration.lua` و `qbcore_integration.lua` را بررسی کنید.

## 🗄️ دیتابیس SQL

فایل `reputation.sql` را در دیتابیس خود import کنید تا جدول ساخته شود.

یا می‌توانید بصورت خودکار به هنگام نصب ساخته شود.

## 👑 دسترسی‌های ادمین

برای ادمین‌ها در `server.cfg` اضافه کنید:

```cfg
add_ace group.admin reputation allow
add_ace group.god reputation allow
```

## ✅ ویژگی‌های جدید

- ✅ بروزرسانی خودکار UI بعد از هر تغییر Trust Factor
- ✅ لیست 10 پلیر برتر با `/leaderboard`
- ✅ دیتابیس SQL برای ذخیره‌سازی دائمی
- ✅ پشتیبانی از رنک admin و god

---

**نسخه:** 1.0.0  
**توسعه‌دهنده:** HesamDev
