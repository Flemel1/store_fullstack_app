<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Response;
use Illuminate\Validation\ValidationException;

class CreateUserRequest extends FormRequest
{

    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\Rule|array|string>
     */
    public function rules(): array
    {
        return [
            'name' => 'required|string',
            'email' => 'required|string|email|unique:users',
            'address' => 'required|string',
            'phone' => 'required|string|min:10',
            'photo' => 'required|mimetypes:image/jpeg,image/png,image/jpg',
            'password' => 'required|string|min:8'
        ];
    }

    protected function failedValidation(Validator $validator): ValidationException
    {
        $response = new Response($validator->errors(), 422);
        throw new ValidationException($validator, $response);
    }
}
