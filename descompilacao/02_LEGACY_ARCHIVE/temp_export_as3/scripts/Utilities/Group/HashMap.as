package Utilities.Group
{
   import flash.utils.Dictionary;
   
   public dynamic class HashMap
   {
      
      private var _hash:Dictionary;
      
      private var _length:int;
      
      private var _temp_arr1:Array;
      
      private var _temp_arr2:Array;
      
      public function HashMap(param1:Boolean = false)
      {
         super();
         this.init(param1);
      }
      
      public function init(param1:Boolean = false) : void
      {
         this._hash = new Dictionary(param1);
         this._length = 0;
      }
      
      public function get length() : int
      {
         return this._length;
      }
      
      public function addItem(param1:Object, param2:Object) : Boolean
      {
         if(this.hasItem(param1))
         {
            return false;
         }
         this._hash[param1] = param2;
         ++this._length;
         return param2;
      }
      
      public function removeItem(param1:Object) : Object
      {
         var _loc2_:Object = null;
         if(!this.getItem(param1))
         {
            return null;
         }
         _loc2_ = this._hash[param1];
         delete this._hash[param1];
         --this._length;
         return _loc2_;
      }
      
      public function hasItem(param1:Object) : Boolean
      {
         if(this._hash[param1])
         {
            return true;
         }
         return false;
      }
      
      public function getItem(param1:Object) : Object
      {
         return this._hash[param1];
      }
      
      public function get getItems() : Array
      {
         var _loc1_:Object = null;
         this._temp_arr1 = [];
         for(_loc1_ in this._hash)
         {
            this._temp_arr1.push(this._hash[_loc1_]);
         }
         return this._temp_arr1;
      }
      
      public function get getkeys() : Array
      {
         var _loc1_:Object = null;
         this._temp_arr2 = [];
         for(_loc1_ in this._hash)
         {
            this._temp_arr2.push(_loc1_);
         }
         return this._temp_arr2;
      }
      
      public function get hash() : Dictionary
      {
         return this._hash;
      }
      
      public function set hash(param1:Dictionary) : void
      {
         this.dispose();
         this._hash = param1;
         this.updateLength();
      }
      
      public function clone() : HashMap
      {
         var _loc1_:HashMap = null;
         var _loc2_:Object = null;
         if(this._hash)
         {
            _loc1_ = new HashMap();
            for(_loc2_ in this.hash)
            {
               _loc1_.addItem(_loc2_,this._hash[_loc2_]);
            }
            return _loc1_;
         }
         return null;
      }
      
      public function concat(param1:HashMap) : void
      {
         var _loc2_:Dictionary = null;
         var _loc3_:Object = null;
         if(param1)
         {
            if(this._hash == null)
            {
               this.init();
            }
            _loc2_ = param1.hash;
            for(_loc3_ in _loc2_)
            {
               this.addItem(_loc3_,_loc2_[_loc3_]);
            }
         }
      }
      
      private function updateLength() : void
      {
         var _loc1_:Object = null;
         if(this._hash)
         {
            for(_loc1_ in this._hash)
            {
               ++this._length;
            }
         }
      }
      
      public function dispose() : void
      {
         this._hash = null;
         this._temp_arr1 = null;
         this._temp_arr2 = null;
         this._length = 0;
      }
      
      public function toObject() : Object
      {
         var _loc2_:Object = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this._hash)
         {
            _loc1_.push("(" + _loc2_ + ":" + this._hash[_loc2_] + ")");
         }
         return _loc1_.join(",");
      }
   }
}

