/*
    ༺ 𝓒𝓸𝓭𝓮𝓭 𝓑𝔂: 𝓢𝓾𝓻𝓪𝓳 𝓜𝓪𝓾𝓻𝔂𝓪 ༻
    ༺ 𝓘𝓓: 𝓼𝓾𝓶𝓬𝓸𝓷𝓼𝓸𝓵𝓮 ༻
*/
#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>
using namespace std;
using namespace __gnu_pbds;

#define gcu getchar_unlocked
#define fof(i, k, n) for (int i = k; i <= n; i++)
#define fob(i, k, n) for (int i = k; i >= n; i--)
#define foi(it, a) for (auto &it : a)
#define fofv(i, k, n, a) for (int i = k; i <= n; i += a)
#define fobv(i, k, n, a) for (int i = k; i >= n; i -= a)
#define Fof(i, k, n) for (i = k; i <= n; i++)
#define Fob(i, k, n) for (i = k; i >= n; i--)
#define Fofv(i, k, n, a) for (i = k; i <= n; i += a)
#define Fobv(i, k, n, a) for (i = k; i >= n; i -= a)
#define Foi(it, a) for (it = a.begin(); it != a.end(); it++)

#define int long long
#define ll long long
#define ull unsigned long long
#define endl '\n'
#define deb(x) cout << #x << "=" << x << endl
#define deb2(x, y) cout << #x << "=" << x << "," << #y << "=" << y << endl
#define clr(x) memset(x, 0, sizeof(x))
#define noOfSetBits(x) __builtin_popcountll(x)
#define noOfZeroBitsTillFirstSetBit(x) __builtin_ctzll(x)
#define prec(x, y) fixed << setprecision(x) << y
#define fast_in_out ios_base::sync_with_stdio(false), cin.tie(nullptr), cout.tie(nullptr)

using pbds = tree<int, null_type, less<int>, rb_tree_tag, tree_order_statistics_node_update>;
mt19937_64 timer(chrono::high_resolution_clock::now().time_since_epoch().count());

int randomNumberGenerator(int startValue, int endValue)
{
    uniform_int_distribution<int> uid(startValue, endValue);
    return uid(timer);
}

void competitive()
{
    fast_in_out;
}

const int INF = 1000000005;
long long INFL = 1000000000000000005LL;
const double PI = 3.14159265358979323846;
const int MOD = 1000000007;
const int N = 2e6 + 13, M = N;

// vector<int> graph[N];
// int arr[N];

//=====================================================================================================

void solve()
{
}

int32_t main()
{
    srand(chrono::high_resolution_clock::now().time_since_epoch().count());
    competitive();
    int t = 1;
    // cin >> t;
    while (t--)
    {
        solve();
    }
    return 0;
}