<?php

namespace App\Http\Controllers\Products;

use App\Models\Product;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        $products = Product::all();
        int:
        $statusCode = 200;
        $data = [
            'status_code' => $statusCode,
            'data' => $products
        ];

        return response()->json($data, $statusCode);
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
    public function show(Product $product): JsonResponse
    {
        int:
        $statusCode = 200;
        $data = [
            'status_code' => $statusCode,
            'data' => $product
        ];

        return response()->json($data, $statusCode);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Product $product)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product)
    {
        //
    }

    public function buy(Request $request): JsonResponse
    {
        $products = $request->products;
        $statusCode = 200;
        $data = [
            'status_code' => $statusCode,
            'data' => []
        ];
        foreach ($products as $product) {
            $id = $product['id'];
            $pcs = $product['pcs'];
            DB::select('call buy_product(?,?)', [$id, $pcs]);

            $data['data'] = 'success';
        }

        return response()->json($data, $statusCode);
    }
}
