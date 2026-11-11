# Personal Finance Tracker

> Every naira, traced to where it went.

A mobile-first personal finance web app for recording income and expenses, tracking what is left in each bank account, and seeing in detail where the money goes. It is a single static page backed by a Supabase database, so your records are stored in your own account and sync across your phone and laptop.

## Contents

- [Features](#features)
- [Expense categories](#expense-categories)
- [Income sources](#income-sources)
- [How the money is calculated](#how-the-money-is-calculated)
- [Home dashboard](#home-dashboard)
- [Reports tab](#reports-tab)
- [Data model](#data-model)
- [Tech stack](#tech-stack)
- [Project structure](#project-structure)
- [Customising the app](#customising-the-app)
- [Security notes](#security-notes)
- [Known limitations](#known-limitations)

## Features

- **Sign in with email and password** (Supabase Auth), with a show/hide password button. Each user only ever sees their own records.
- **Two entry types:** expenses and income, each with date and time.
- **Bank-aware expenses:** every expense records the bank it was paid from (UBA, Stanbic IBTC or Opay) and an optional transaction fee.
- **Balance protection:** an expense cannot be saved from a bank with no funds, or for more than the bank holds (amount plus fee).
- **Detailed categories** with subcategories, and extra inputs where they matter (network and plan for data, bags of water, kilograms of gas, and more).
- **Home dashboard** with charts, bank balances, a transaction fee report and a subcategory breakdown.
- **Reports tab** where you build a report by picking filters. It loads only after you have made your selections.
- **Flexible date filters:** this month, last month, last 3 months, this year, all time, or a custom range chosen on a single calendar.
- **Light and dark mode** toggle, remembered on each device, following the device setting until you choose.
- **Mobile-optimised layout** with compact text, pills and tables so more fits on a phone screen.
- **Remembers your place:** your last tab, period and custom range survive a refresh.

## Expense categories

Categories and subcategories are listed alphabetically wherever they appear.

| Category | Subcategories and inputs |
| --- | --- |
| Airtime | Network: Airtel, Glo, MTN |
| Appliances | Free text: which appliance |
| Clothes | Adela, Gift, Leroy, Raphael |
| Data | Network (Airtel, Glo, MTN), then a validity pill (Daily, Weekly, Monthly and so on, depending on the network), then a plan dropdown. **Other** validity lets you type a plan. |
| Electricity | Amount only |
| Food | All Purpose, Beans, Curry, Eggs, Egusi, Fish, Fufu, G. Oil, Garri, Knoor, Kpomo, Lasor, Meat, Okra, Ogbona, Onions, P. Oil, Pepper, Potatoes, Rice Bag, Sachet Tomatoes, Shombo, Thyme, Tomatoes, Yams |
| Gas | Kilograms bought and amount |
| Health & Wellness | Medicine, then **Adult** or **Kids** |
| Others | Free text: what it was for (required) |
| Personal Expenses | Free text: which accessory |
| Rent | Amount only |
| School Fees and Books | Adela, Leroy |
| Shoes | Adela, Gift, Leroy, Raphael |
| Snacks | Biscuits, Golden Morn, Milk, Sugar |
| Sports Betting | Platform dropdown: Football.com, SportsBet.io, Sportybet, Stake.com |
| Toiletries | Adult Soap, Adult TPaste, Body Spray, Conditioner, Hair Cream, Kids Soap, Kids TPaste, Liquid Soap, Perfume, Roll On, Shampoo, TBrush, Vaseline, Washing Soap |
| Transport | Type of transport (Airplane, Boat, Bus, Taxi Ride, Train, Trek), then free-text destination and reason |
| Water | Number of bags and amount |

Every expense also takes the bank it was paid from, an optional **transaction fee**, an amount, a date and a time.

## Income sources

Business, Crypto Futures, Crypto Spot, Mutual Funds Investment, My Wife, Other, Salary, Sports Betting Winnings.

Choosing **Other** shows a text box. What you type is saved as the income source, so the word "Other" is never stored. Each income entry also records the bank it was received into.

## How the money is calculated

The app has no separate withdrawal step. Expenses are paid straight from a bank, and balances follow from that.

- **Bank balance** = income received into the bank − expenses paid from it − transaction fees on those expenses.
- **Left in banks** is the sum of the three balances.
- **Spent** counts expense amounts only. **Transaction fees** are tracked and reported separately, so you can see how much you pay just to move money. They are never mixed into category totals.
- **Funds check:** when you save an expense the app compares amount plus fee with the bank's balance. It shows the balance under the bank pills while you fill in the form.
- **Older withdrawal entries** (the app used to have a Withdraw entry type) still count against the bank they came from, and their fees show up as "Old withdrawals" in the fee report. Older expenses saved before banks were recorded appear in category charts but not in any bank's figures.
- Balances are calculated on all-time data, whatever the entry dates are. The period filter only affects the spending figures and charts.

## Home dashboard

Top to bottom:

1. **Period filter:** This month, Last month, Last 3 months, This year, All time, Custom. **Custom** opens one calendar: tap a start date, then an end date.
2. **Spending summary:** total spent in the period, the fees on top, and a coloured bar showing the category split.
3. **Tiles:** Income, Spent, Transaction fees, Left in banks.
4. **Banks:** each bank's balance, plus what came out of it in the period and a bar for its share.
5. **Spending by category:** a donut chart and ranked bars. Tapping a slice or a bar jumps to its subcategories.
6. **Last 6 months by category:** stacked monthly bars.
7. **Transaction fees:** total fees, share of spending, number and average, by bank and by category.
8. **Subcategories:** pick a category from the dropdown to see each item with its amount, share, number of purchases and average price. Items you have not bought show as ₦0. Water and Gas also show the price per bag or kilogram, and Data and Health & Wellness add a breakdown by plan or by Kids/Adult.

## Reports tab

Choose what you want to see, and the report appears once the required selections are made.

- **Income:** optionally filter by income source and bank. The table shows income source, bank, amount, date and time.
- **Expense:** choose a category (or **All categories**), optionally narrow it, and filter by bank. The table adapts to the category:

| Category | Columns |
| --- | --- |
| All categories | Category, Subcategory, Bank, Amount, Date, Time |
| Data | Network, Validity, Plan, Bank, Amount, Date, Time (with a Validity filter) |
| Airtime | Network, Bank, Amount, Date, Time |
| Health & Wellness | Subcategory, Who is it for, Bank, Amount, Date, Time (with a Kids/Adult filter) |
| Sports Betting and other categories with subcategories | Subcategory or Platform, Bank, Amount, Date, Time |
| Water, Gas | Bags or Kg, Bank, Amount, Date, Time |
| Transport | Type, Destination, Reason, Bank, Amount, Date, Time |
| Others, Personal Expenses, Appliances, Rent, Electricity | Your note (for example "What was it for"), Bank, Amount, Date, Time |

A **Fee** column is added whenever any of the listed expenses has a transaction fee. Every report shows totals, number of entries, the average and a breakdown by item and by bank above the table, and a total row at the bottom. The date filter is shared with the Home tab.

## Data model

All records live in one table, `entries`, with row level security so each user only reads and writes their own rows.

| Column | Type | Purpose |
| --- | --- | --- |
| `id` | text | Primary key, generated in the app |
| `user_id` | uuid | Owner, filled in by Supabase (`auth.uid()`) |
| `t` | text | Entry type: `i` income, `x` expense, `w` withdrawal (legacy, no longer created) |
| `d` | date | Date of the entry |
| `tm` | text | Time as `HH:MM` |
| `a` | numeric | Amount in naira |
| `src` | text | Income source (or the text typed for **Other**) |
| `bank` | text | Bank received into (income) or paid from (expense) |
| `cat` | text | Expense category |
| `sub` | text | Subcategory, network or platform |
| `q` | numeric | Quantity: bags of water or kilograms of gas |
| `note` | text | Extra detail, see below |
| `reason` | text | Reason for the entry (used by Transport) |
| `fee` | numeric | Optional transaction fee |
| `created_at` | timestamptz | Created time, set by Supabase |

How the `note` and `sub` columns are used by category:

| Category | `sub` | `note` |
| --- | --- | --- |
| Data | Network | Plan and validity, for example `10GB monthly` |
| Health & Wellness | `Medicine` | `Adult` or `Kids` |
| Transport | Type of transport | Destination (the reason is in `reason`) |
| Others, Personal Expenses, Appliances | empty | What it was for |
| Water, Gas | empty | empty, quantity is in `q` |
| Other categories | The chosen item | Optional extra text |

Dates and times are stored in local time as entered, and amounts are formatted for `en-NG`.

## Tech stack

- **Front end:** one static `index.html` with vanilla JavaScript, no framework and no build step.
- **Database and auth:** Supabase (Postgres, Auth and row level security), using `supabase-js` v2 loaded from a CDN.
- **Charts:** hand-written inline SVG (donut, stacked bars and trends), so there are no charting libraries.
- **UI:** custom components for the dropdowns, the date-range calendar and the theme toggle, with light and dark colour tokens.
- **Hosting:** any static host. The project is deployed on Vercel.
- **Font:** Bricolage Grotesque for headings, with system fonts for the rest.

## Project structure

```
.
├── index.html   # the whole app: markup, styles and logic
├── schema.sql   # database table, indexes and row level security policy
└── README.md
```

## Customising the app

The lists that drive the forms and reports sit together near the top of the script in `index.html`:

- `BANKS`: the bank accounts.
- `SRC`: the income sources.
- `C`: the expense categories. Each entry has an emoji (`e`), an optional subcategory list (`s`), and optional extras such as a quantity unit, a note label (`f`, with `req` to make it required), plan or option lists (`p`) and a dropdown flag (`dd`).
- `PLN`: the data plan sizes for each network and validity.
- `CI` and `COL`: the order and colour palette used for chart colours.

To add a category, add it to `C` and append its name to the end of `CI` with a new colour at the end of `COL`, so existing categories keep their colours. Lists are sorted alphabetically on load. Nothing needs to change in the database, because categories and subcategories are stored as plain text.

To change old records after renaming or moving a category, update the `cat`, `sub` and `note` columns with a SQL `update` in the Supabase SQL editor. Run a `select` with the same `where` clause first to preview the rows.

## Security notes

- The page contains only the Supabase project URL and the public (anon or publishable) key. This is safe because row level security limits every request to the signed-in user's own rows.
- Never put a Supabase secret key or `service_role` key in the page, since those bypass row level security.
- After your account exists, turn off new signups in Supabase so nobody else can register.
- The bank balance check runs in the browser. It prevents mistakes in the app, but it is not enforced by the database.

## Known limitations

- **No edit or delete in the app.** Correct or remove an entry in the Supabase Table Editor, or with SQL.
- **Single currency.** All amounts are naira.
- **Fixed banks and categories.** Changing them means editing `index.html`.
- **Online only.** There is no offline mode, so entries cannot be saved without a connection.
- **Balances need income.** A bank with no recorded income cannot be used for expenses.
