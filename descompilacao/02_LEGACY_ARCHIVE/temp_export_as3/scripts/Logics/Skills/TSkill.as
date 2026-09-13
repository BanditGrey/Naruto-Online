package Logics.Skills
{
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.Common.TEntity;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.Spaces.LogicsSpace;
   import Resources.Constants.CONST_DATEBASEVO;
   
   use namespace LogicsSpace;
   
   public class TSkill extends TEntity
   {
      
      public static const SKILL_TYPE_NORMAL:int = 0;
      
      public static const SKILL_TYPE_AWAKEN:int = 1;
      
      protected var FStubReferences:TStubReferences;
      
      protected var FIDTexture:uint;
      
      protected var FName:String;
      
      protected var FDescription:String;
      
      protected var FMounted:Boolean;
      
      protected var FSort:uint;
      
      protected var FScreeningVector:Array;
      
      protected var FType:int;
      
      protected var FAwakeDesc:String;
      
      public function TSkill(param1:uint)
      {
         super(param1);
         this.FStubReferences = new TStubReferences(this);
      }
      
      LogicsSpace function Coerce(param1:uint) : void
      {
         FIdentifier = param1;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get IDTexture() : uint
      {
         return this.FIDTexture;
      }
      
      public function set IDTexture(param1:uint) : void
      {
         this.FIDTexture = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function set Description(param1:String) : void
      {
         this.FDescription = param1;
      }
      
      public function get Mounted() : Boolean
      {
         return this.FMounted;
      }
      
      public function set Mounted(param1:Boolean) : void
      {
         this.FMounted = param1;
      }
      
      public function get Sort() : uint
      {
         return this.FSort;
      }
      
      public function set Sort(param1:uint) : void
      {
         this.FSort = param1;
      }
      
      public function get ScreeningVector() : Array
      {
         return this.FScreeningVector;
      }
      
      public function set Identifier(param1:uint) : void
      {
         FIdentifier = param1;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function set Type(param1:int) : void
      {
         this.FType = param1;
      }
      
      public function get AwakeDesc() : String
      {
         return this.FAwakeDesc;
      }
      
      public function set AwakeDesc(param1:String) : void
      {
         this.FAwakeDesc = param1;
      }
      
      public function SetValueForOneselfBySkillId(param1:uint) : void
      {
         var _loc2_:TSkillConfig = null;
         FIdentifier = param1;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,param1) as TSkillConfig;
         if(!_loc2_)
         {
            throw new Error("SkillConfig��δ����" + param1);
         }
         this.FName = _loc2_.Name;
         this.FDescription = _loc2_.Desc;
         this.FSort = _loc2_.SortId;
         this.FIDTexture = _loc2_.Icon;
         this.FScreeningVector = _loc2_.ScreeningVector;
         this.FType = _loc2_.Type;
         this.FAwakeDesc = _loc2_.Awakedesc;
      }
   }
}

