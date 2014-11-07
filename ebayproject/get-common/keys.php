<?php
/*  © 2007-2013 eBay Inc., All Rights Reserved */
/* Licensed under CDDL 1.0 -  http://opensource.org/licenses/cddl1.php */

    //show all errors - useful whilst developing
    error_reporting(E_ALL);

    // these keys can be obtained by registering at http://developer.ebay.com
    
    $production         = true;   // toggle to true if going against production
    $compatabilityLevel = 867;    // eBay API version
    
    if ($production) {
        $devID = 'c93d3820-47e0-4e88-aab0-637be3de7697';   // these prod keys are different from sandbox keys
        $appID = 'compands-ba02-4925-8b2b-f61fa8b6d75f';
        $certID = '008470dd-2ed3-4993-86a9-14c9842bf32e';
        //set the Server to use (Sandbox or Production)
        $serverUrl = 'https://api.ebay.com/ws/api.dll';      // server URL different for prod and sandbox
        //the token representing the eBay user to assign the call with
        $userToken = 'AgAAAA**AQAAAA**aAAAAA**s3hhUw**nY+sHZ2PrBmdj6wVnY+sEZ2PrA2dj6wMlIaoDJWLoQqdj6x9nY+seQ**bzYCAA**AAMAAA**Eliek0xSZvUeQxGW88bZof1MfJi5eQw1Icy0VXH666H96xAt1jUKGHGEBMj9XrNKUQ4wq0HcEKuBd2N0G/pxVkGspOQpvYjKGGqymgaFg0gPsHs1lQmNzpTvceWtOgjwaMluxbIKPRdKvNR3V/U99Gkzeuu8ittHOhpsG+u6wsWlrTy76enUZL95lu1/7GrYKLaevKDB5WcdzP0UbYM6OY98fF8uW2eA7fpwbt0CMNWrPwNzqZVsO0GVMdo0CMCKWhaWGNUHTiez/JvSNg6A0TUvv92nrmC1GUnFIVs4+pPdHhizDSyQb+YZyH2xl++Id3qwrlY5dIDV5DNvX6XLBV5TL+tSqc6UqMNL47OL0EHhGhDN/f3WJ5wBA1SAfk770YnCz9kcJ4QDCOBGMzxoLZ/pUVJkgL/vFAi/j3gVA6o/NoMIuWBWpJbBl/7I2PoMggUjRoQ1tKcpEn4Sqd/PD0RNun3mmwutlG8biX6VgFTLfevajxop85OyuoHAYLk0ncP2Txbw9tz7+zjJyP69DP2hqrTS5Mjj0CK4QGt3AjNsfLhHCl3SYARBCPZBz+DhSyiyJ89Cz/jUGp2hdn/L6yYJBfrkLio5QxiHiDiqIulYwZS4VmIhRD1Wse4T58kVV2xohtXDCUk/mGcFpZhADunKFOeMihqP/Cyw4IVH3fOY89ZD6CdqkQNpseICw9dtDExHcoKjfbSLdATRyMRUNY4ZCe/7KdTakPlGbegGZJLOGeV1zQ3Q8hk4eTgtPNR2'; 
        $paypalEmailAddress= 'PRODUCTION_PAYPAL_EMAIL_ADDRESS';		
    } else {  
        $devID = 'c93d3820-47e0-4e88-aab0-637be3de7697';         // insert your devID for sandbox
        $appID = 'compands-3aa1-4a22-aa1f-38d71a7778f2';   // different from prod keys
        $certID = 'd43e93f9-5c79-4894-af52-ff333d4a2341';  // need three 'keys' and one token
        //set the Server to use (Sandbox or Production)
        $serverUrl = 'https://api.sandbox.ebay.com/ws/api.dll';
        // the token representing the eBay user to assign the call with
        // this token is a long string - don't insert new lines - different from prod token
        $userToken = 'AgAAAA**AQAAAA**aAAAAA**1RJhUw**nY+sHZ2PrBmdj6wVnY+sEZ2PrA2dj6wJnY+lDpOGowqdj6x9nY+seQ**/LUCAA**AAMAAA**wLG7amjpUwbBzxBMaxBqYOAtMK+Z/QcsnjFZTPzRLghcue0OivhCiemnXf5HOVUpJur0mFgcT2quKLqDvO90G9tyOPkhJC3e6ebuzuBuOtu6CoKf7SxnycBQHeveeilv6KkW1N1MHziwasJtigkKRoVCUuTkpRsvugnj+u+nkkJ3JhMFn6SDk75r3n1uma4j4kJCoiuD3BnYn+nlM9L/ThLbqU2x9/yE/Ey3MkcOXoLb1AkZJrUmUQdWg0Il8gdfA4WAEmV/C9XO47AAWRfwIDjFOxVpOQgB7jl2R3j4a3r4BVtke5/hyKSuuYFkMpmpzHUxVX8p5YlyV/z6XBXYNPxyHwXAHB8cojsdpAT++m8Ew3eqwObmbNV3pQOxiT+rkISZa6eBqta5PhH2YE2LIFol3mEPixaZyzhN/lK0aZ7Hg/tJ1mRIA0ftyiMxEUxaQjGCni9aNWGcqytEKF5JhJCAjHJyOgI7UhnGvyAOFJ9JZ0xUGBxc8P1n7Axt6+11CB7lYXoo0S5LOpP0nDL5ChUokE1cvmBpa6sIdKznZ8OXuVuKhA1wyI8MMvXoeSoHFILqgYzanjNmggdVQCcJzM5HUjyudecaz9p0Gdn+PmS9/CHfSB/t4k+w4ZUC7wqyh6w3Fuoz7kM/v+ahxvgA8l3QStLdfAVTw0F0Gw03WY7FxdQKDw6hhtvzVraJx+gcN+W+3t0bNJUxRbvlN4I3r9Od2d0nxF2VUAG84+GmlgTNKL89rX3d/e2h3HSJLpIP'; 
		$paypalEmailAddress = 'SANDBOX_PAYPAL_EMAIL_ADDRESS';		
    }
    
    
?>