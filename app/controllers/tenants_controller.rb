class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Tenant.all
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def create
        tenant = Tenant.create(tenant_params)
        render json: tenant, status: :created
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        render json: tenant
    end

    def update
        tenant = tenant.find(params[:id])
        tenant.update(tenant_params)
        render json: tenant, status: :accepted
    end

    private

    def tenant_params
        params.permit(params[:name, :age])
    end

    def render_not_found_response
        render json: { error: "Tenant not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
