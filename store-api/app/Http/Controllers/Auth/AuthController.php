<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\CreateUserRequest;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{

    public function login(Request $request)
    {
        $data = [];
        $statusCode = 200;
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            $statusCode = 400;
            $data = [
                'status_code' => $statusCode,
                'data' => [
                    'message' => $validator->errors()
                ]
            ];
            return response()->json($data, 400);
        }

        $credentials = $request->only('email', 'password');

        $isValidUser = Auth::attempt($credentials);
        if (!$isValidUser) {
            $statusCode = 401;
            $response = [
                'status_code' => $statusCode,
                'data' => [
                    'message' => 'email atau password anda salah'
                ],
            ];
            return response()->json($response, $statusCode);
        }
        $user = User::where('email', $request->email)->first();
        $response = [
            'status_code' => $statusCode,
            'data' => [
                'user' => $user,
                'token' => $user->createToken($request->email)->plainTextToken,
            ]
        ];
        return response()->json($response, $statusCode);
    }

    public function register(CreateUserRequest $request)
    {
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'address' => $request->address,
            'phone' => $request->phone,
            'photo_url' => url()->to('/') . "/uploads/" . $request->file('photo')->storePublicly('users', 'public'),
            'password' => Hash::make($request->password)
        ]);

        return response()
            ->json(['status_code' => 200, 'data' => $user]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
