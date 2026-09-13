package Foundation.Resources.Repositories
{
   import Foundation.Common.*;
   import Foundation.Resources.Streamization.Textures.*;
   import Foundation.Resources.Textures.*;
   import Logics.*;
   import Logics.Characters.*;
   import Resources.Constants.*;
   
   public class TResourceRepositoryTexture extends TResourceRepository
   {
      
      private static const INSTANCETYPE_TEXTURE_MODEL:String = "Resources/Textures/Model/";
      
      public function TResourceRepositoryTexture(param1:String, param2:uint)
      {
         super(param1,param2);
         FIsAutoRelease = true;
      }
      
      override protected function ConstructLoaders() : void
      {
         FLoaderPrimary = new TResourceLoaderTexture(FResourcePath,".TexClient",FPoolResourceRequest,TYPE_Primary,FPriority);
         FLoaderPrimary.OnResourceUnstreamized = LoadersOnResourceUnstreamized;
         FLoaderPrimary.OnLoadFailedResource = ProcessorLoadFailedResources;
         FLoaderSecondary = new TResourceLoaderTexture(FResourcePath,".TexClient",FPoolResourceRequest,TYPE_Secondary,FPriority + 100);
         FLoaderSecondary.OnResourceUnstreamized = LoadersOnResourceUnstreamized;
         FLoaderSecondary.OnLoadFailedResource = ProcessorLoadFailedResources;
      }
      
      private function ProcessorReleaseRoleModel(param1:uint) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:THeros = null;
         var _loc5_:THero = null;
         _loc4_ = SLogicsCore.Character.Heros;
         _loc3_ = _loc4_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.GetHeroByIndex(_loc2_);
            if(_loc5_.Mounted)
            {
               if(_loc5_.ModelID == param1)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      public function GetTextureByIdentifier(param1:uint) : TTexture
      {
         return FResources.GetEntityByIdentifier(param1) as TTexture;
      }
      
      public function GetAnimationSequenceByIdentifiers(param1:uint, param2:uint) : TAnimationSequence
      {
         var _loc3_:TTexture = null;
         _loc3_ = FResources.GetEntityByIdentifier(param1) as TTexture;
         if(_loc3_ != null)
         {
            return _loc3_.GetAnimationSequenceByIdentifier(param2);
         }
         return null;
      }
      
      override public function DeleteByIdentifier(param1:uint) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:TTexture = null;
         _loc3_ = FResources.GetEntityByIdentifier(param1) as TTexture;
         if(_loc3_ == null)
         {
            return false;
         }
         _loc2_ = FResources.IndexOf(_loc3_);
         FResources.Delete(_loc2_);
         _loc3_.Clear();
         return super.DeleteByIdentifier(param1);
      }
      
      override public function LoadPrimary(param1:uint, param2:uint = 0) : void
      {
         if(param1 == 0)
         {
            return;
         }
         super.LoadPrimary(param1,param2);
      }
      
      override public function LoadSecondary(param1:uint, param2:uint = 0) : void
      {
         if(param1 == 0)
         {
            return;
         }
         super.LoadSecondary(param1,param2);
      }
      
      override public function DeleteLoadingByIdentifier(param1:uint) : void
      {
         var _loc2_:int = 0;
         _loc2_ = FAutoReleaseResourceID.indexOf(param1);
         if(_loc2_ >= 0)
         {
            FAutoReleaseResourceID.splice(_loc2_,1);
            FAutoLoadSourceModules.splice(_loc2_,1);
         }
         super.DeleteLoadingByIdentifier(param1);
      }
      
      override public function PerformAutoReleaseResource(param1:uint) : void
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:uint = 0;
         var _loc9_:Boolean = false;
         _loc8_ = uint(SLogicsCore.Character.CurModuleID);
         _loc3_ = int(FAutoReleaseResourceID.length);
         _loc2_ = int(_loc3_ - 1);
         for(; _loc2_ >= 0; _loc2_--)
         {
            if(param1 == FAutoLoadSourceModules[_loc2_])
            {
               _loc5_ = FAutoReleaseResourceID[_loc2_];
               _loc6_ = true;
               _loc3_ = int(FAutoReleaseResourceID.length);
               _loc4_ = int(_loc3_ - 1);
               while(_loc4_ >= 0)
               {
                  if(_loc2_ != _loc4_ && _loc5_ == FAutoReleaseResourceID[_loc4_])
                  {
                     _loc6_ = false;
                     break;
                  }
                  _loc4_--;
               }
               if(_loc6_)
               {
                  if(INSTANCETYPE_TEXTURE_MODEL == FInstanceType)
                  {
                     if(param1 == CONST_MODULES.MODULE_Battle && (_loc8_ == CONST_MODULES.MODULE_FightPet || _loc8_ == CONST_MODULES.MODULE_FightPetCopy || _loc8_ == CONST_MODULES.MODULE_TraitorAttack))
                     {
                        FAutoReleaseResourceID.splice(_loc2_,1);
                        FAutoLoadSourceModules.splice(_loc2_,1);
                        continue;
                     }
                     _loc9_ = this.ProcessorReleaseRoleModel(_loc5_);
                  }
                  else if(!CONST_COMMON.GAME_MemCriticalUpperLimit())
                  {
                     continue;
                  }
                  if(!_loc9_)
                  {
                     _loc7_ = this.DeleteByIdentifier(_loc5_);
                     if(_loc7_)
                     {
                        FAutoReleaseResourceID.splice(_loc2_,1);
                        FAutoLoadSourceModules.splice(_loc2_,1);
                     }
                     else
                     {
                        this.DeleteLoadingByIdentifier(_loc5_);
                     }
                  }
               }
            }
         }
      }
   }
}

