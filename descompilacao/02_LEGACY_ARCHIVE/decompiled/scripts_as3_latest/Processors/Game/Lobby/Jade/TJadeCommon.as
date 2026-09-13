package Processors.Game.Lobby.Jade
{
   import Components.Slots.*;
   import Foundation.Queries.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.TBaseStone;
   import Logics.Inventories.*;
   import Resources.Constants.*;
   import flash.display.*;
   
   public class TJadeCommon
   {
      
      public function TJadeCommon()
      {
         super();
      }
      
      public static function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,(param1 as TUISlot).ModuleId);
         }
      }
      
      public static function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         if(param2 is TInventory)
         {
            _loc4_ = param2 as TInventory;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      public static function ProcessorUpdateSlotsRenderingState(param1:Vector.<TUISlot>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUISlot = null;
         _loc3_ = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1[_loc2_];
            _loc4_.Update();
            _loc2_++;
         }
      }
      
      public static function InitSlot(param1:TUISlot, param2:uint) : void
      {
         param1.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         param1.OnQuerySequenceContext = SlotsOnQuerySequenceContext;
         param1.ModuleId = param2;
         param1.OnQuerySubscript = SlotsOnQuerySubscript;
      }
      
      public static function GetSpecialJade(param1:TInventories, param2:TInventories, param3:int, param4:int, param5:int = 0) : void
      {
         var _loc6_:TInventory = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TBaseStone = null;
         _loc8_ = param1.Count;
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc6_ = param1.GetInventoryByIndex(_loc7_);
            _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseStone,_loc6_.IDTemplate) as TBaseStone;
            if(!(param3 != -1 && _loc6_.RequirementLevel != param3))
            {
               if(!(param4 != -1 && param4 != _loc6_.CategorySecond))
               {
                  if(!(param5 != 0 && !_loc9_))
                  {
                     if(_loc6_.IDTemplate != 14510001)
                     {
                        param2.Add(_loc6_);
                     }
                  }
               }
            }
            _loc7_++;
         }
      }
   }
}

